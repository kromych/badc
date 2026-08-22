
bitfield_incdec.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movl	$0x80000001, %ecx       # imm = 0x80000001
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movl	$0x80000002, %ecx       # imm = 0x80000002
               	movl	%ecx, (%rax)
               	movl	$0x80000003, %edx       # imm = 0x80000003
               	movl	%edx, (%rax)
               	movl	%ecx, (%rax)
               	movl	%edx, (%rax)
               	movl	$0x80000002, %ecx       # imm = 0x80000002
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
