
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
               	movq	%rax, %rcx
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x4000, %rcx           # imm = 0x4000
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x8000, %rcx           # imm = 0x8000
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0xc000, %rcx           # imm = 0xC000
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x10000, %rcx          # imm = 0x10000
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	0x1(%rax), %rcx
               	andq	$0x3fff, %rcx           # imm = 0x3FFF
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x14, %eax
               	retq
               	addq	$0x2000, %rax           # imm = 0x2000
               	andq	$0x3fff, %rax           # imm = 0x3FFF
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0xb, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0x16, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	addq	$0x4000, %rcx           # imm = 0x4000
               	movl	$0x21, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rcx
               	addq	$0x14000, %rcx          # imm = 0x14000
               	movl	$0x2c, %edx
               	movl	%edx, (%rcx)
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x16, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x4000, %rax           # imm = 0x4000
               	movslq	(%rax), %rax
               	cmpl	$0x21, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x14000, %rax          # imm = 0x14000
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
