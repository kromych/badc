
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

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x1(%rdi), %r8
               	leaq	0x2(%rdi), %rax
               	leaq	0x3(%rdi), %r9
               	leaq	0x4(%rdi), %rbx
               	leaq	0x5(%rdi), %rdx
               	leaq	0x6(%rdi), %r12
               	leaq	0x7(%rdi), %r13
               	leaq	0x8(%rdi), %r14
               	leaq	0x9(%rdi), %rcx
               	leaq	0xa(%rdi), %r15
               	leaq	0xb(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0xc(%rdi), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0xd(%rdi), %rsi
               	leaq	0xe(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0xf(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	addq	%r8, %rdi
               	addq	%r9, %rdi
               	addq	%rbx, %rdi
               	addq	%r12, %rdi
               	addq	%r13, %rdi
               	addq	%r14, %rdi
               	addq	%rcx, %rdi
               	addq	%r15, %rdi
               	addq	0x58(%rsp), %rdi
               	addq	0x50(%rsp), %rdi
               	addq	0x48(%rsp), %rdi
               	addq	0x40(%rsp), %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	shlq	%rdx
               	addq	%rdx, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0xa, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0xbf, %ebx
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
