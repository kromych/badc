
builtin_str_compare_fold.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rax, %rax
               	movl	$0x61, %ecx
               	movb	%cl, (%rdi)
               	movl	$0x62, %ecx
               	movb	%cl, 0x1(%rdi)
               	movl	$0x63, %ecx
               	movb	%cl, 0x2(%rdi)
               	movb	%al, 0x3(%rdi)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	movsbq	(%rsi), %rax
               	movl	%eax, %eax
               	subq	$0x61, %rax
               	movl	%eax, %eax
               	addq	$0x3, %rax
               	movl	%eax, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
