
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x61, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x62, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %edx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x64, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
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
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	0x10(%rax), %rdi
               	leaq	<rip>, %r8
               	leaq	<rip>, %r9
               	movsbq	(%rsi), %rax
               	cmpq	$0x65, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rdi), %rax
               	cmpq	$0x66, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	0x10(%rax), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	leaq	<rip>, %r8
               	leaq	<rip>, %r9
               	movsbq	(%rsi), %rax
               	cmpq	$0x67, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rdi), %rax
               	cmpq	$0x68, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x7(%r12), %rax
               	cmpq	$0x69, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	movsbq	0x8(%r12), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x6a, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x6b, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
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
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	(%rdi,%rdx), %r9
               	movsbq	(%r9), %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rdx
               	leaq	(%r8,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	0x10(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	0x10(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	(%r8,%rdx), %rdi
               	movsbq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rcx
               	leaq	(%r8,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r8,%rcx), %rbx
               	movsbq	(%rbx), %rbx
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rcx
               	leaq	(%r9,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r9,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rcx
               	leaq	(%r8,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r8,%rcx), %rbx
               	movsbq	(%rbx), %rbx
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rcx
               	leaq	(%r9,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r9,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	(%rdi,%rdx), %r9
               	movsbq	(%r9), %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rdx
               	leaq	(%r8,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	0x10(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	0x10(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	(%r8,%rdx), %rdi
               	movsbq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	(%rdi,%rdx), %r9
               	movsbq	(%r9), %r9
               	cmpq	%r9, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rdx
               	leaq	(%r8,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	0x10(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	0x10(%rax), %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	(%r8,%rdx), %rdi
               	movsbq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	jmp	<addr>
