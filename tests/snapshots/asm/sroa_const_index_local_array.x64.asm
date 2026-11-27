
sroa_const_index_local_array.x64:	file format elf64-x86-64

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

<rounds>:
               	pushq	%rbx
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	movq	0x10(%rdi), %rdx
               	movq	0x18(%rdi), %r8
               	movq	0x20(%rdi), %r9
               	movq	0x28(%rdi), %r10
               	movq	0x30(%rdi), %r11
               	movq	0x38(%rdi), %rdi
               	leaq	-0x1(%rsi), %rbx
               	testl	%esi, %esi
               	jle	<addr>
               	movq	%rdi, %rsi
               	shlq	%rsi
               	addq	%r11, %rsi
               	shlq	%r11
               	addq	%r10, %r11
               	shlq	%r10
               	addq	%r9, %r10
               	shlq	%r9
               	addq	%r8, %r9
               	shlq	%r8
               	addq	%rdx, %r8
               	shlq	%rdx
               	addq	%rcx, %rdx
               	shlq	%rcx
               	addq	%rax, %rcx
               	shlq	%rax
               	xorq	%rdi, %rax
               	movq	%rsi, %rdi
               	movq	%rbx, %rsi
               	leaq	-0x1(%rsi), %rbx
               	testl	%esi, %esi
               	jg	<addr>
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%r10, %rax
               	addq	%r11, %rax
               	addq	%rdi, %rax
               	popq	%rbx
               	retq

<main>:
               	subq	$0x48, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x1118, 0x8(%rsp)      # imm = 0x1118
               	movq	$0x2229, 0x10(%rsp)     # imm = 0x2229
               	movq	$0x333a, 0x18(%rsp)     # imm = 0x333A
               	movq	$0x444b, 0x20(%rsp)     # imm = 0x444B
               	movq	$0x555c, 0x28(%rsp)     # imm = 0x555C
               	movq	$0x666d, 0x30(%rsp)     # imm = 0x666D
               	movq	$0x777e, 0x38(%rsp)     # imm = 0x777E
               	leaq	(%rsp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x14ebf84, %rax        # imm = 0x14EBF84
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
