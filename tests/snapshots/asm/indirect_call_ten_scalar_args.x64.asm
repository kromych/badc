
indirect_call_ten_scalar_args.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	leaq	0x8(%rax), %r12
               	leaq	0x9(%rax), %r13
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%rdx,%rdx,2), %rcx
               	addq	%rcx, %rax
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rdi,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r8, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %r9, %rcx
               	addq	%rcx, %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	leaq	(%r12,%r12,8), %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %r13, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x181, %rax            # imm = 0x181
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
