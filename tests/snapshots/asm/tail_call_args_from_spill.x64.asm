
tail_call_args_from_spill.x64:	file format elf64-x86-64

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

<stir>:
               	movl	<rip>, %eax # <addr>
               	xorq	$0x1, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<sink>:
               	shlq	%rsi
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	retq

<forward>:
               	subq	$0x78, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x1(%rbx), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	0x2(%rbx), %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	0x3(%rbx), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	0x4(%rbx), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0x5(%rbx), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x6(%rbx), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	0x7(%rbx), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0x8(%rbx), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0x9(%rbx), %r12
               	leaq	0xa(%rbx), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0xb(%rbx), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0xc(%rbx), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0xd(%rbx), %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	0xe(%rbx), %r10
               	movq	%r10, 0x30(%rsp)
               	leaq	0xf(%rbx), %r10
               	movq	%r10, 0x28(%rsp)
               	callq	<addr>
               	movq	%rbx, %rax
               	addq	0x78(%rsp), %rax
               	addq	0x70(%rsp), %rax
               	addq	0x68(%rsp), %rax
               	addq	0x60(%rsp), %rax
               	addq	0x58(%rsp), %rax
               	addq	0x50(%rsp), %rax
               	addq	%r12, %rax
               	addq	0x48(%rsp), %rax
               	addq	0x40(%rsp), %rax
               	addq	0x38(%rsp), %rax
               	addq	0x30(%rsp), %rax
               	addq	0x28(%rsp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x78, %rsp
               	retq
               	movq	%r12, %rdx
               	movq	0x20(%rsp), %rdi
               	movq	0x18(%rsp), %rsi
               	movq	0x10(%rsp), %rcx
               	popq	%rbx
               	popq	%r12
               	addq	$0x78, %rsp
               	jmp	<addr>

<main>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movl	$0xa, 0x18(%rsp)
               	movl	0x18(%rsp), %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	cmpl	$0xbf, %ebx
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
