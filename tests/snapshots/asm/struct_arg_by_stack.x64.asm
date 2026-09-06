
struct_arg_by_stack.x64:	file format elf64-x86-64

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

<mutate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movq	%rcx, (%rax)
               	movq	0x18(%rax), %rdx
               	decq	%rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x8(%rax), %rsi
               	addq	%rsi, %rcx
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	leaq	(%rcx,%rdx), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x50(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x16, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x21, %ecx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x2c, %ecx
               	movq	%rcx, 0x18(%rax)
               	movl	$0x5, %ecx
               	movl	$0x6, %edx
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	movq	0x10(%rax), %r8
               	movq	0x18(%rax), %rax
               	movl	$0x7, %r9d
               	leaq	<rip>, %rbx
               	movq	%r9, (%rbx)
               	leaq	<rip>, %r9
               	movq	%rsi, (%r9)
               	leaq	<rip>, %rsi
               	movq	%rdi, (%rsi)
               	leaq	<rip>, %rsi
               	movq	%r8, (%rsi)
               	leaq	<rip>, %rsi
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x455, %rax            # imm = 0x455
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0xb, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x2c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
