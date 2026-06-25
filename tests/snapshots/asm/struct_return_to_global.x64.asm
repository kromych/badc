
struct_return_to_global.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<store_global>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	<rip>, %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rbx
               	movl	$0x6, %eax
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x60(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	movq	(%rbx), %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	leaq	(%rdx,%rax), %r12
               	movslq	%edx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%edx, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x70(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	leaq	-0x70(%rbp), %rcx
               	movl	$0x1, %esi
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x70(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %r12
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	(%rbx), %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
