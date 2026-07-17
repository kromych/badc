
break_continue.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3f, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	andq	$0x1, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	jmp	<addr>
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0xa, %rdx
               	jl	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
