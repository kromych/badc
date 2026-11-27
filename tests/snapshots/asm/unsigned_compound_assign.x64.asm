
unsigned_compound_assign.x64:	file format elf64-x86-64

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

<rtu>:
               	subq	$0x18, %rsp
               	movl	%edi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
               	retq

<rtul>:
               	subq	$0x18, %rsp
               	movq	$0x3e8, 0x8(%rsp)       # imm = 0x3E8
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	movl	$0x64, %edi
               	callq	<addr>
               	leaq	0x5(%rax), %rsi
               	cmpl	$0x69, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	<addr>
               	leaq	0x19f(%rax), %rsi
               	cmpq	$0x587, %rsi            # imm = 0x587
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x41c, %edi            # imm = 0x41C
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	$0x502, %edi            # imm = 0x502
               	callq	<addr>
               	subq	$0x363, %rax            # imm = 0x363
               	movq	0x8(%rsp), %rsi
               	addq	%rax, %rsi
               	cmpl	$0x5bb, %esi            # imm = 0x5BB
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0xc8, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	leaq	0x3c(%rax), %rsi
               	andq	$0xff, %rsi
               	cmpl	$0x4, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
               	xorl	%edx, %edx
               	movabsq	$0xa00000000, %rcx      # imm = 0xA00000000
               	movq	%rcx, 0x10(%rsp)
               	movabsq	$0x1e00000014, %rcx     # imm = 0x1E00000014
               	movq	%rcx, 0x18(%rsp)
               	movl	$0x28, 0x20(%rsp)
               	movq	%rax, 0x28(%rsp)
               	movq	0x28(%rsp), %rax
               	movl	0xc(%rax), %esi
               	cmpl	$0x1e, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	%rdx, %rax
               	addq	$0x38, %rsp
               	retq
