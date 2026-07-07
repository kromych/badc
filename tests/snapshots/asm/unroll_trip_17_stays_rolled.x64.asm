
unroll_trip_17_stays_rolled.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	%rax, (%rdx,%rax,8)
               	incq	%rax
               	cmpq	$0x11, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rax,8), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpq	$0x11, %rax
               	jl	<addr>
               	cmpq	$0x88, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
