
slot_coalesce_disjoint_temps.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	jmp	<addr>
               	movq	%r9, %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rsi
               	cmpq	$0xa, %rsi
               	setg	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x64, %rsi
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rsi
               	movq	%rsi, %rbx
               	sarq	$0x3f, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	andq	$0x1, %r12
               	movq	%rbx, %r10
               	movq	%r12, %rbx
               	subq	%r10, %rbx
               	testq	%rbx, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpq	$0x32, %rsi
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rdx, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %r8
               	movq	%r9, %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rsi
               	cmpq	$0xa, %rsi
               	setg	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x64, %rsi
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rsi
               	movq	%rsi, %rbx
               	sarq	$0x3f, %rbx
               	shrq	$0x3f, %rbx
               	leaq	(%rsi,%rbx), %r12
               	andq	$0x1, %r12
               	movq	%rbx, %r10
               	movq	%r12, %rbx
               	subq	%r10, %rbx
               	testq	%rbx, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpq	$0x32, %rsi
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rdx, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x7(%rax), %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x7(%rax), %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	leaq	0x1(%r9), %rax
               	movslq	%eax, %r9
               	cmpq	$0x40, %r9
               	jl	<addr>
               	movslq	%r8d, %rax
               	movslq	%edi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
