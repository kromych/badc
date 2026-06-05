
function_macro.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	movq	%rax, 0x10(%rbp)
               	movq	%rsi, %rax
               	movq	%rax, 0x20(%rbp)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	movq	0x20(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	movq	%r14, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1f, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x29, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
