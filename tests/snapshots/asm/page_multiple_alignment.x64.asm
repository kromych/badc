
page_multiple_alignment.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	testl	$0x3fff, %edx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rsi
               	testl	$0x3fff, %esi           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rdx
               	testl	$0x3fff, %edx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	0x4000(%rdx), %rdi
               	testl	$0x3fff, %edi           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	0x8000(%rdx), %r8
               	testl	$0x3fff, %r8d           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	0xc000(%rdx), %r8
               	testl	$0x3fff, %r8d           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	addq	$0x10000, %rdx          # imm = 0x10000
               	testl	$0x3fff, %edx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	0x1(%rax), %rdx
               	testl	$0x3fff, %edx           # imm = 0x3FFF
               	jne	<addr>
               	movl	$0x14, %eax
               	retq
               	addq	$0x2000, %rax           # imm = 0x2000
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	jne	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	$0xb, (%rcx)
               	movl	$0x16, (%rsi)
               	movl	$0x21, (%rdi)
               	leaq	<rip>, %rax
               	addq	$0x14000, %rax          # imm = 0x14000
               	movl	$0x2c, (%rax)
               	movslq	(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x16, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x4000, %rcx           # imm = 0x4000
               	movslq	(%rcx), %rcx
               	cmpl	$0x21, %ecx
               	jne	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorl	%eax, %eax
               	retq
