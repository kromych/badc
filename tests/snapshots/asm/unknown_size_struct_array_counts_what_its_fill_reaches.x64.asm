
unknown_size_struct_array_counts_what_its_fill_reaches.x64:	file format elf64-x86-64

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
               	subq	$0x58, %rsp
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x6261, 0x20(%rsp)     # imm = 0x6261
               	movb	$0x0, 0x22(%rsp)
               	movl	$0x7, 0x24(%rsp)
               	movw	$0x6564, 0x28(%rsp)     # imm = 0x6564
               	movb	$0x0, 0x2a(%rsp)
               	movl	$0x2, 0x2c(%rsp)
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x6261, 0x30(%rsp)     # imm = 0x6261
               	movb	$0x0, 0x32(%rsp)
               	movl	$0x1, 0x34(%rsp)
               	movw	$0x6564, 0x38(%rsp)     # imm = 0x6564
               	movb	$0x0, 0x3a(%rsp)
               	movl	$0x7, 0x3c(%rsp)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x6261, 0x40(%rsp)     # imm = 0x6261
               	movb	$0x0, 0x42(%rsp)
               	movl	$0x7, 0x44(%rsp)
               	movw	$0x6564, 0x48(%rsp)     # imm = 0x6564
               	movb	$0x0, 0x4a(%rsp)
               	movl	$0x2, 0x4c(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x14, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	leaq	0x10(%rsp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rax
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x24(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	0x30(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x34(%rsp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	0x30(%rsp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x30(%rsp), %rax
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	0x40(%rsp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rax
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	leaq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x14(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
