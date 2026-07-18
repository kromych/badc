
unsigned_char_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movzbq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movzbq	0x5(%rax), %rcx
               	xorq	$0x6, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movzbq	0x5(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movzbq	0x9(%rax), %rcx
               	xorq	$0xa, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movzbq	0x9(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x64, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	0x20(%rcx), %rcx
               	cmpq	$0x1f4, %rcx            # imm = 0x1F4
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movzbq	0x5(%rax), %rcx
               	xorq	$0x6, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movzbq	0x5(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
