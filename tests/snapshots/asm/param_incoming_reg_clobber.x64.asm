
param_incoming_reg_clobber.x64:	file format elf64-x86-64

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
               	movw	$0x201, (%rsp)          # imm = 0x201
               	movw	$0x403, 0x2(%rsp)       # imm = 0x403
               	movw	$0x605, 0x4(%rsp)       # imm = 0x605
               	leaq	(%rsp), %rcx
               	movl	$0x8, %edx
               	movw	$0x807, 0x6(%rsp)       # imm = 0x807
               	leaq	0x8(%rsp), %rax
               	addq	$0x7, %rax
               	leaq	-0x1(%rdx), %rsi
               	decq	%rax
               	incq	%rcx
               	movsbq	-0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movq	%rsi, %rdx
               	leaq	-0x1(%rdx), %rsi
               	testl	%edx, %edx
               	jne	<addr>
               	xorl	%eax, %eax
               	movsbq	0x8(%rsp), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	addq	$0xa, %rax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	movsbq	0x9(%rsp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	$0x2, %eax
               	movsbq	0xa(%rsp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	$0x3, %eax
               	movsbq	0xb(%rsp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	movsbq	0xc(%rsp), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	$0x5, %eax
               	movsbq	0xd(%rsp), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	$0x6, %eax
               	movsbq	0xe(%rsp), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	$0x7, %eax
               	leaq	0x8(%rsp), %rcx
               	movsbq	0xf(%rsp), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movl	$0x8, %edx
               	leaq	-0x1(%rdx), %rsi
               	incq	%rcx
               	incq	%rax
               	movsbq	-0x1(%rax), %rdx
               	movb	%dl, -0x1(%rcx)
               	movq	%rsi, %rdx
               	leaq	-0x1(%rdx), %rsi
               	testl	%edx, %edx
               	jne	<addr>
               	xorl	%eax, %eax
               	movsbq	0x8(%rsp), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	addq	$0x14, %rax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	movsbq	0x9(%rsp), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	$0x2, %eax
               	movsbq	0xa(%rsp), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	$0x3, %eax
               	movsbq	0xb(%rsp), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	movsbq	0xc(%rsp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x5, %eax
               	movsbq	0xd(%rsp), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	$0x6, %eax
               	movsbq	0xe(%rsp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	$0x7, %eax
               	movsbq	0xf(%rsp), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
