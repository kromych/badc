
overaligned_type_placement.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	testb	$0x7f, %cl
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	testb	$0x3f, %dl
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	testb	$0x7f, %dl
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	testb	$0x7f, %sil
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0xb, (%rax)
               	movl	$0x16, (%rcx)
               	movl	$0x21, (%rdx)
               	movl	$0x2c, (%rsi)
               	movl	(%rax), %eax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x21, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
