
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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x9(%rax), %r10
               	movq	%r10, 0x10(%rsp)
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%rdx,%rdx,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	leaq	(%rdi,%rdi,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r8, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %r9, %rcx
               	addq	%rcx, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	0x18(%rsp), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x181, %rax            # imm = 0x181
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
