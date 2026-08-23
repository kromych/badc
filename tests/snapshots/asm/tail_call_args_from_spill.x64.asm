
tail_call_args_from_spill.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leaq	0x1(%rax), %rdx
               	leaq	0x2(%rax), %rsi
               	leaq	0x3(%rax), %rdi
               	leaq	0x4(%rax), %r8
               	leaq	0x5(%rax), %r9
               	leaq	0x6(%rax), %rbx
               	leaq	0x7(%rax), %r12
               	leaq	0x8(%rax), %r13
               	leaq	0x9(%rax), %rcx
               	leaq	0xa(%rax), %r14
               	leaq	0xb(%rax), %r15
               	leaq	0xc(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	0xd(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	0xe(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0xf(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	addq	%rdx, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%rcx, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	0x78(%rsp), %rax
               	addq	0x68(%rsp), %rax
               	addq	0x60(%rsp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpl	$0xbf, %ebx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%r9, %rax
               	shlq	%rax
               	addq	%rsi, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rbx
               	jmp	<addr>
