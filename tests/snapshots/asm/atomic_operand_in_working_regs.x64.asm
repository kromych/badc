
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
               	movq	%r8, 0x8(%rsp)
               	movq	%rcx, 0x10(%rsp)
               	movl	$0x64, %eax
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x5, %edx
               	movq	%rax, -0x50(%rsp)
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	movq	%rax, %r10
               	movq	-0x50(%rsp), %rax
               	movq	%r10, %rcx
               	cmpq	$0x64, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	movq	%rcx, %r8
               	cmovneq	%rax, %r8
               	leaq	<rip>, %rax # <addr>
               	leaq	(%rdi,%rsi), %rcx
               	lock
               	xaddq	%rcx, (%rax)
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpq	$0x9, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	0x9(%rdi), %rcx
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	(%rdi,%rsi), %rax
               	addq	0x18(%rsp), %rax
               	addq	0x10(%rsp), %rax
               	addq	0x8(%rsp), %rax
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
