
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	(%rcx,%rcx,2), %rdi
               	movslq	%edi, %r8
               	movslq	%r8d, %rdi
               	cmpq	$0xa, %rdi
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	$0x64, %rdi
               	setl	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	-0x1(%r8), %rdi
               	movslq	%edi, %r9
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	sarq	$0x3f, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%r12,%rdi), %rbx
               	andq	$0x1, %rbx
               	movq	%rdi, %r10
               	movq	%rbx, %rdi
               	subq	%r10, %rdi
               	testq	%rdi, %rdi
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpq	$0x32, %r12
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r9, %rdi
               	shlq	$0x1, %rdi
               	movslq	%edi, %r12
               	leaq	(%r12,%r8), %rdi
               	addq	%r9, %rdi
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	(%rcx,%rcx,2), %rdi
               	movslq	%edi, %r8
               	movslq	%r8d, %rdi
               	cmpq	$0xa, %rdi
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	$0x64, %rdi
               	setl	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	-0x1(%r8), %rdi
               	movslq	%edi, %r9
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	sarq	$0x3f, %rdi
               	shrq	$0x3f, %rdi
               	leaq	(%r12,%rdi), %rbx
               	andq	$0x1, %rbx
               	movq	%rdi, %r10
               	movq	%rbx, %rdi
               	subq	%r10, %rdi
               	testq	%rdi, %rdi
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpq	$0x32, %r12
               	setg	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%r9, %rdi
               	shlq	$0x1, %rdi
               	movslq	%edi, %r12
               	leaq	(%r12,%r8), %rdi
               	addq	%r9, %rdi
               	addq	%rdi, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%r8), %rdi
               	movslq	%edi, %r9
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x7(%rcx), %rdi
               	movslq	%edi, %r8
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%r8), %rdi
               	movslq	%edi, %r9
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x7(%rcx), %rdi
               	movslq	%edi, %r8
               	jmp	<addr>
               	leaq	0x1(%rsi), %rcx
               	movslq	%ecx, %rsi
               	cmpq	$0x40, %rsi
               	jl	<addr>
               	movslq	%edx, %rcx
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
