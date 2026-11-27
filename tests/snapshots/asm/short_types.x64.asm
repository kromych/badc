
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<rt>:
               	subq	$0x18, %rsp
               	movl	%edi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x4d2, %edi            # imm = 0x4D2
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movq	$-0x2a, %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0x4d2, %ecx            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movswq	%ax, %rax
               	cmpl	$-0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rcx, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	imulq	$0x7, %rax, %rax
               	subq	%rax, %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movswq	%ax, %rcx
               	movq	%rcx, %rax
               	shlq	$0xe, %rax
               	movswq	%ax, %rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%rcx, %rax
               	shlq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leaq	-0x10000(%rax), %rdx
               	testl	$0x8000, %eax           # imm = 0x8000
               	cmovneq	%rdx, %rax
               	movswq	%ax, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%rcx, %rax
               	shlq	$0xf, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leaq	-0x10000(%rax), %rcx
               	testl	$0x8000, %eax           # imm = 0x8000
               	cmovneq	%rcx, %rax
               	movswq	%ax, %rax
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$-0x8, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	sarq	%rax
               	cmpl	$-0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xfffe, %edi           # imm = 0xFFFE
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rax, 0x8(%rsp)
               	cmpl	$0xffff, %edx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x1(%rcx), %rax
               	testl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	(%rsp), %rcx
               	movswq	%cx, %rcx
               	leaq	(%rax,%rcx), %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	%eax, %ecx
               	ja	<addr>
               	movl	$0x10, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0xf, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x8000, %edi           # imm = 0x8000
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	sarq	%rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	$0xc8, %edi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movq	$-0x12c, %rdi           # imm = 0xFED4
               	callq	<addr>
               	movswq	%ax, %rax
               	movq	0x8(%rsp), %rcx
               	movswq	%cx, %rcx
               	movq	(%rsp), %rdx
               	movswq	%dx, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leaq	-0x10000(%rax), %rcx
               	testl	$0x8000, %eax           # imm = 0x8000
               	cmovneq	%rcx, %rax
               	movswq	%ax, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movq	$-0x7, %rdi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movl	$0xc0de, %edi           # imm = 0xC0DE
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movswq	%cx, %rcx
               	movq	(%rsp), %rdx
               	movswq	%dx, %rdx
               	addq	%rdx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x18, %rsp
               	retq
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xc0de, %eax           # imm = 0xC0DE
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x18, %rsp
               	retq
