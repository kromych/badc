
local_array_runtime_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movl	$0x1234, %eax           # imm = 0x1234
               	movw	%ax, 0xa(%rcx)
               	leaq	<rip>, %rdx
               	movl	$0x5678, %eax           # imm = 0x5678
               	movw	%ax, 0xa(%rdx)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	%esi, (%rax)
               	movzwq	0xa(%rcx), %rcx
               	movw	%cx, (%rax)
               	movzwq	0xa(%rdx), %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	(%rax), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x477198, %eax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x63, %edx
               	movb	%dl, (%rax)
               	movl	$0x62, %edx
               	movb	%dl, 0x1(%rax)
               	movl	$0x3, %edx
               	movb	%dl, 0x2(%rax)
               	movl	$0x64, %edx
               	movb	%dl, 0x3(%rax)
               	addq	$0x0, %rax
               	movsbq	(%rax), %rax
               	leaq	(%rax), %rcx
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
