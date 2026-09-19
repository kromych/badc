
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
               	leaq	<rip>, %rcx
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	testl	$0x3fff, %edx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %r8
               	testl	$0x3fff, %r8d           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rsi
               	testl	$0x3fff, %esi           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	0x4000(%rsi), %r9
               	testl	$0x3fff, %r9d           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8000(%rax), %rdi
               	testl	$0x3fff, %edi           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	0xc000(%rax), %rdi
               	testl	$0x3fff, %edi           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	addq	$0x10000, %rax          # imm = 0x10000
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	0x1(%rcx), %rax
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	jne	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	0x2000(%rcx), %rax
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	jne	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	$0xb, (%rdx)
               	movl	$0x16, (%r8)
               	movl	$0x21, (%r9)
               	leaq	<rip>, %rax
               	leaq	0x14000(%rax), %rcx
               	movl	$0x2c, (%rcx)
               	movslq	(%rdx), %rdx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x16, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	addq	$0x4000, %rdx           # imm = 0x4000
               	movslq	(%rdx), %rdx
               	cmpl	$0x21, %edx
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorl	%eax, %eax
               	retq
