
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
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	jmp	<addr>
               	movq	0x10(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, -0x8(%rbp)
               	cmpq	$0x0, %rsi
               	je	<addr>
               	jmp	<addr>
               	leaq	0x10(%rbp), %rsi
               	movq	(%rsi), %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rsi)
               	leaq	0x20(%rbp), %r8
               	movq	(%r8), %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r8)
               	jmp	<addr>
               	movq	0x10(%rbp), %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x10(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	0x10(%rbp), %rdi
               	movzbq	(%rdi), %rdi
               	movq	0x20(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	%rsi, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	0x20(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
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
               	movl	$0x15, %esi
               	movq	%rsi, %rcx
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
               	movl	$0x16, %esi
               	movq	%rsi, %rcx
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
               	movl	$0x17, %esi
               	movq	%rsi, %rcx
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
               	movl	$0x18, %r12d
               	movq	%r12, %rcx
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
               	movl	$0x19, %r14d
               	movq	%r14, %rcx
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
               	movl	$0x1f, %esi
               	movq	%rsi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %r9
               	movslq	%r9d, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%r9d, %r9
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x29, %esi
               	movq	%rsi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
