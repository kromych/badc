
static_object_pc_relative.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<store_imm>:
               	movq	$-0x1, <rip> # <addr>
               	movl	$0x12345678, <rip> # imm = 0x12345678
                                                # <addr>
               	movw	$0xfffe, <rip> # imm = 0xFFFE
                                                # <addr>
               	movb	$-0x80, <rip> # <addr>
               	movb	$-0x1, <rip> # <addr>
               	movw	$0xffff, <rip> # imm = 0xFFFF
                                                # <addr>
               	movl	$0x80000000, <rip> # imm = 0x80000000
                                                # <addr>
               	movb	$0x7a, <rip> # <addr>
               	movw	$0x12c, <rip> # imm = 0x12C
                                                # <addr>
               	movl	$0xfffffff9, <rip> # imm = 0xFFFFFFF9
                                                # <addr>
               	movq	$0x7fffffff, <rip> # imm = 0x7FFFFFFF
                                                # <addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, <rip> # <addr>
               	movl	$0x21, <rip> # <addr>
               	movl	$0x4d, <rip> # <addr>
               	retq

<sum>:
               	movq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movswq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movzbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movzwq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movswq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movslq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movslq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movslq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	retq

<store_reg>:
               	movq	%rdi, <rip> # <addr>
               	movl	%edi, <rip> # <addr>
               	movw	%di, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	retq

<zero_tests>:
               	xorl	%eax, %eax
               	movsbq	<rip>, %rcx # <addr>
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movswq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	orq	$0x2, %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movslq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	orq	$0x8, %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movzbq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	orq	$0x10, %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	retq

<floats>:
               	movsd	<rip>, %xmm0 # <addr>
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movsd	<rip>, %xmm1 # <addr>
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	retq

<counter>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<vol>:
               	movl	$0x5, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	callq	<addr>
               	movabsq	$0x1123558ff, %r11      # imm = 0x1123558FF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpl	$0x1f, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x100000000, %rdi      # imm = 0x100000000
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	$-0x3, %rdi
               	callq	<addr>
               	callq	<addr>
               	movabsq	$0x1000102fe, %r11      # imm = 0x1000102FE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
