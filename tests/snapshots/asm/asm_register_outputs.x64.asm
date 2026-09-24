
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
               	movq	%rax, %rbx
               	movq	%rbx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	movq	0x10(%rax), %rax
               	movq	%rax, %rbx
               	movq	%rcx, %rax
               	addq	%rbx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	movq	%rax, %rbx
               	movl	%ebx, %eax
               	movl	%ebx, %edx
               	shrl	%edx
               	movl	%edx, -0x8(%rbp)
               	movl	%eax, %eax
               	movl	-0x8(%rbp), %ecx
               	addq	%rcx, %rax
               	cmpq	$0x1b4e81a, %rax        # imm = 0x1B4E81A
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rcx
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rbx
               	movb	%bl, %al
               	movq	%rax, %rdx
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rbx
               	movw	%bx, %ax
               	movq	%rdx, %rcx
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
               	movq	%rax, %rbx
               	movq	%rbx, %rax
               	movq	%rax, %rcx
               	movq	%rcx, %rbx
               	movq	%rbx, %rax
               	addq	$0x1, %rax
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x1093, %rax           # imm = 0x1093
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rax
               	movq	$0x0, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rdx, (%rcx)
               	movq	%rax, %rbx
               	movq	%rbx, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rax
               	movq	%rax, %rbx
               	movq	%rbx, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
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
