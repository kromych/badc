
zero_length_array_sizeof.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %r9 # <addr>
               	movq	%rax, %rdx
               	cmpl	$0x4, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	nopl	(%rax,%rax)
               	testl	%esi, %esi
               	jne	<addr>
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	movzbq	(%r9,%rcx), %rcx
               	incq	%rax
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rsi
               	movq	%rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsp,%rdx)
               	cmpl	$0x4, %esi
               	jge	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0x4, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movzbq	(%rsp), %rcx
               	cmpl	$0x42, %ecx
               	jne	<addr>
               	movzbq	0x1(%rsp), %rcx
               	cmpl	$0x41, %ecx
               	jne	<addr>
               	movzbq	0x2(%rsp), %rcx
               	cmpl	$0x44, %ecx
               	jne	<addr>
               	movzbq	0x3(%rsp), %rcx
               	cmpl	$0x43, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
