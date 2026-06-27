
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
               	subq	$0x90, %rsp
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
               	leaq	(%rcx,%rcx,2), %rsi
               	movslq	%esi, %rdi
               	jmp	<addr>
               	leaq	0x7(%rcx), %rsi
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
               	leaq	-0x1(%rdi), %rsi
               	movslq	%esi, %r8
               	jmp	<addr>
               	leaq	0x1(%rdi), %rsi
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
               	movq	%r8, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %r9
               	jmp	<addr>
               	movslq	%r8d, %r9
               	leaq	(%r9,%rdi), %rsi
               	addq	%r8, %rsi
               	addq	%rsi, %rdx
               	movslq	%ecx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	(%rcx,%rcx,2), %rsi
               	movslq	%esi, %rdi
               	movslq	%edi, %rsi
               	cmpq	$0xa, %rsi
               	setg	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	jmp	<addr>
               	leaq	0x7(%rcx), %rsi
               	movslq	%esi, %rdi
               	jmp	<addr>
               	movslq	%edi, %rsi
               	cmpq	$0x64, %rsi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	leaq	-0x1(%rdi), %rsi
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
               	leaq	0x1(%rdi), %rsi
               	movslq	%esi, %r8
               	jmp	<addr>
               	movslq	%r8d, %rsi
               	cmpq	$0x32, %rsi
               	setg	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	%r8, %rsi
               	shlq	$0x1, %rsi
               	movslq	%esi, %r9
               	leaq	(%r9,%rdi), %rsi
               	addq	%r8, %rsi
               	addq	%rsi, %rax
               	jmp	<addr>
               	movslq	%r8d, %r9
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
