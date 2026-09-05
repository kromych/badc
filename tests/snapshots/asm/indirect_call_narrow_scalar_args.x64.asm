
indirect_call_narrow_scalar_args.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movq	%rcx, %rax
               	movsbq	%al, %r9
               	movswq	%ax, %rbx
               	imulq	$0x186a0, %r9, %rdx     # imm = 0x186A0
               	imulq	$0xa, %rbx, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	leaq	(%rdi,%rcx), %rax
               	cmpl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	cmpl	$0x6bcd17, %eax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
