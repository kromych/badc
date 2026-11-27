
atomic_operand_in_working_regs.x64:	file format elf64-x86-64

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

<f>:
               	subq	$0x28, %rsp
               	movq	%rdx, 0x18(%rsp)
               	movq	%rcx, 0x10(%rsp)
               	movl	$0x64, %r10d
               	leaq	<rip>, %r11 # <addr>
               	movl	$0x5, %eax
               	movq	%r9, 0x8(%rsp)
               	movq	%r8, (%rsp)
               	movq	%rax, %r9
               	movq	%r10, %rax
               	lock
               	cmpxchgq	%r9, (%r11)
               	cmpq	$0x64, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	cmoveq	%rax, %r10
               	movq	0x8(%rsp), %r9
               	movq	(%rsp), %r8
               	leaq	(%rdi,%rsi), %rax
               	movq	%r10, 0x8(%rsp)
               	movq	%r9, (%rsp)
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%r11)
               	movq	0x8(%rsp), %r10
               	movq	(%rsp), %r9
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpq	$0x9, %r10
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpq	$0x9, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %r10 # <addr>
               	movq	(%r10), %r10
               	addq	$0x9, %rdi
               	addq	%rdi, %rsi
               	cmpq	%rsi, %r10
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	addq	0x18(%rsp), %rax
               	addq	0x10(%rsp), %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x30(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<main>:
               	movl	$0x64, %edx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x5, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rcx)
               	cmpq	$0x64, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmoveq	%rax, %rdx
               	movl	$0x3, %eax
               	movq	%rax, %rdi
               	lock
               	xaddq	%rdi, (%rcx)
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x9, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	cmpq	$0x9, %rdi
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
