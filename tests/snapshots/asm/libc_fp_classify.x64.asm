
libc_fp_classify.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rax
               	movabsq	$0x4008000000000000, %r11 # imm = 0x4008000000000000
               	orq	%r11, %rax
               	movq	%rax, %xmm0
               	movabsq	$-0x3ff8000000000000, %rax # imm = 0xC008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rax
               	movabsq	$0x4008000000000000, %r11 # imm = 0x4008000000000000
               	orq	%r11, %rax
               	movq	%rax, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$-0x3fec000000000000, %rax # imm = 0xC014000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rax
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	orq	%r11, %rax
               	movq	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0xc0000000, %eax       # imm = 0xC0000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x7f800000, -0x8(%rbp) # imm = 0x7F800000
               	movl	-0x8(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x7fc00000, -0x8(%rbp) # imm = 0x7FC00000
               	movl	-0x8(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
