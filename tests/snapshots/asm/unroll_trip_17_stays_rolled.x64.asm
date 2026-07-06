
unroll_trip_17_stays_rolled.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx,%rax,8)
               	incq	%rax
               	cmpq	$0x11, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax,%rcx,8), %rax
               	addq	%rax, %rsi
               	incq	%rcx
               	cmpq	$0x11, %rcx
               	jl	<addr>
               	cmpq	$0x88, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x11, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
