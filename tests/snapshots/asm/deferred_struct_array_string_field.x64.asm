
deferred_struct_array_string_field.x64:	file format elf64-x86-64

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

<check>:
               	movq	%rdx, %r8
               	movq	(%rdi), %rax
               	movsbq	(%rax), %rax
               	movsbq	(%rsi), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rdi), %rax
               	movsbq	(%rax), %rax
               	movsbq	(%r8), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rdi), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	(%rdi), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%rsi,%rcx), %r9
               	movsbq	(%r9), %r9
               	cmpq	%r9, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rcx
               	leaq	(%r8,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x10(%rdi), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rdi), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r8,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rbx), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	0x18(%rbx), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rax
               	movsbq	0x7(%rax), %rax
               	cmpq	$0x69, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rax
               	movsbq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
