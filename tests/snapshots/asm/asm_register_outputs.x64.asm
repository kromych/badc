
asm_register_outputs.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rbx
               	movl	%ebx, %eax
               	movl	%ebx, %edx
               	shrl	%edx
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x1b4e81a, %rax        # imm = 0x1B4E81A
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, %cl
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, %ax
               	andq	$0xff, %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	addq	%rcx, %rax
               	cmpl	$0x8a56, %eax           # imm = 0x8A56
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	movq	%rax, %rax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	cmpq	$0x1093, %rax           # imm = 0x1093
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rcx
               	movq	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, (%rax)
               	movq	%rcx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rbx
               	movq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
