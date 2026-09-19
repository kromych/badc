
libc_math_fdim_scalbn.x64:	file format elf64-x86-64

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

<scalbn>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<scalbln>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<scalbnf>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	ja	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	subsd	%xmm15, %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	ja	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	subsd	%xmm15, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	ja	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movq	%rax, %xmm15
               	movq	%rax, %xmm0
               	subsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x3, %edi
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	$-0x1, %rdi
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x4, %edi
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x2, %edi
               	movq	%rax, %xmm0
               	callq	<addr>
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rcx, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	ja	<addr>
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	ucomisd	%xmm1, %xmm1
               	jp	<addr>
               	je	<addr>
               	subsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
