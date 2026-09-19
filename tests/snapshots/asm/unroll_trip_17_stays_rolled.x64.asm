
unroll_trip_17_stays_rolled.x64:	file format elf64-x86-64

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
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	movq	%rcx, %rax
               	cmpl	$0x11, %eax
               	jge	<addr>
               	movq	%rax, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	cmpl	$0x11, %eax
               	jge	<addr>
               	movq	(%rdx,%rax,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	cmpq	$0x88, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpl	$0x11, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	retq
