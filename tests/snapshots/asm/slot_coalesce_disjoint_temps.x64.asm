
slot_coalesce_disjoint_temps.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	jmp	<addr>
               	movslq	%eax, %r9
               	movq	%r9, %r12
               	andq	$0x1, %r12
               	testq	%r12, %r12
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0xa, %ecx
               	setg	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpl	$0x64, %ecx
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
               	leaq	(%rsi,%rbx), %r13
               	andq	$0x1, %r13
               	subq	%rbx, %r13
               	testq	%r13, %r13
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x32, %edx
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %r8
               	testq	%r12, %r12
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0xa, %ecx
               	setg	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpl	$0x64, %ecx
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
               	subq	%rbx, %r12
               	testq	%r12, %r12
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%r12, %r12
               	je	<addr>
               	cmpl	$0x32, %edx
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rdx, %rsi
               	shlq	%rsi
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
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%edi, %r8d
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
