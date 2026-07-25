
inline_asm_x64_c_mem.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movl	<rip>, %eax
               	movq	-0x58(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movq	<rip>, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x18(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x40, %edx
               	movq	%rax, -0x60(%rbp)
               	movq	%rbx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	leaq	-0x7(%rax), %rbx
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x48(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	movq	-0x20(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
