
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
               	subq	$0xa0, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movslq	%ecx, %rsi
               	cmpq	$0x40, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movslq	%esi, %rdi
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	addq	$0x7, %rsi
               	movslq	%esi, %rdi
               	movslq	%edi, %rsi
               	cmpq	$0xa, %rsi
               	setg	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movslq	%edi, %rsi
               	cmpq	$0x64, %rsi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movslq	%edi, %rsi
               	decq	%rsi
               	movslq	%esi, %r8
               	jmp	<addr>
               	movslq	%edi, %rsi
               	incq	%rsi
               	movslq	%esi, %r8
               	movslq	%r8d, %rsi
               	movq	%rsi, %r9
               	sarq	$0x3f, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rsi
               	andq	$0x1, %rsi
               	subq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	movslq	%r8d, %rsi
               	cmpq	$0x32, %rsi
               	setg	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movslq	%r8d, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %r9
               	jmp	<addr>
               	movslq	%r8d, %r9
               	movslq	%edx, %rdx
               	movslq	%r9d, %rsi
               	movslq	%edi, %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movslq	%r8d, %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rdx
               	movslq	%ecx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%ecx, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movslq	%esi, %rdi
               	movslq	%edi, %rsi
               	cmpq	$0xa, %rsi
               	setg	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	addq	$0x7, %rsi
               	movslq	%esi, %rdi
               	jmp	<addr>
               	movslq	%edi, %rsi
               	cmpq	$0x64, %rsi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movslq	%edi, %rsi
               	decq	%rsi
               	movslq	%esi, %r8
               	movslq	%r8d, %rsi
               	movq	%rsi, %r9
               	sarq	$0x3f, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rsi
               	andq	$0x1, %rsi
               	subq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	jmp	<addr>
               	movslq	%edi, %rsi
               	incq	%rsi
               	movslq	%esi, %r8
               	jmp	<addr>
               	movslq	%r8d, %rsi
               	cmpq	$0x32, %rsi
               	setg	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movslq	%r8d, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %r9
               	movslq	%eax, %rax
               	movslq	%r9d, %rsi
               	movslq	%edi, %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movslq	%r8d, %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rax
               	jmp	<addr>
               	movslq	%r8d, %r9
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
