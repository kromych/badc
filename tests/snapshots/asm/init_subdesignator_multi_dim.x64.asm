
init_subdesignator_multi_dim.x64:	file format elf64-x86-64

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

<check>:
               	xorl	%ecx, %ecx
               	movzwq	(%rdi), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzwq	0x2(%rdi), %rax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movzwq	0xa(%rdi), %rax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x24(%rdi), %rax
               	cmpl	$0x5, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x2c(%rdi), %rax
               	cmpl	$0x6, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x98(%rdi), %rax
               	cmpl	$0x9, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movzwq	0x6(%rdi), %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x18(%rdi), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x3c(%rdi), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x148, %rsp            # imm = 0x148
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	movzwq	(%rdi), %rax
               	movzwq	0x2(%rdi), %rcx
               	movzwq	0xa(%rdi), %rdx
               	movl	0x24(%rdi), %esi
               	movl	0x2c(%rdi), %r8d
               	movl	0x98(%rdi), %r9d
               	leaq	-0x140(%rbp), %rbx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rbx)
               	movups	%xmm14, 0x10(%rbx)
               	movups	%xmm14, 0x20(%rbx)
               	movups	%xmm14, 0x30(%rbx)
               	movups	%xmm14, 0x40(%rbx)
               	movups	%xmm14, 0x50(%rbx)
               	movups	%xmm14, 0x60(%rbx)
               	movups	%xmm14, 0x70(%rbx)
               	movups	%xmm14, 0x80(%rbx)
               	movq	$0x0, 0x90(%rbx)
               	movl	$0x0, 0x98(%rbx)
               	movw	%ax, -0x140(%rbp)
               	leaq	-0x140(%rbp), %rax
               	movw	%cx, 0x2(%rax)
               	movw	%dx, 0xa(%rax)
               	leaq	-0x140(%rbp), %rax
               	movl	%esi, 0x24(%rax)
               	movl	%r8d, 0x2c(%rax)
               	movl	%r9d, 0x98(%rax)
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	movq	0x50(%rcx), %rdx
               	movq	%rdx, 0x50(%rax)
               	movq	0x58(%rcx), %rdx
               	movq	%rdx, 0x58(%rax)
               	movq	0x60(%rcx), %rdx
               	movq	%rdx, 0x60(%rax)
               	movq	0x68(%rcx), %rdx
               	movq	%rdx, 0x68(%rax)
               	movq	0x70(%rcx), %rdx
               	movq	%rdx, 0x70(%rax)
               	movq	0x78(%rcx), %rdx
               	movq	%rdx, 0x78(%rax)
               	movq	0x80(%rcx), %rdx
               	movq	%rdx, 0x80(%rax)
               	movq	0x88(%rcx), %rdx
               	movq	%rdx, 0x88(%rax)
               	movq	0x90(%rcx), %rdx
               	movq	%rdx, 0x90(%rax)
               	movzbq	0x98(%rcx), %rdx
               	movb	%dl, 0x98(%rax)
               	movzbq	0x99(%rcx), %rdx
               	movb	%dl, 0x99(%rax)
               	movzbq	0x9a(%rcx), %rdx
               	movb	%dl, 0x9a(%rax)
               	movzbq	0x9b(%rcx), %rdx
               	movb	%dl, 0x9b(%rax)
               	popq	%rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x140(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x54(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movslq	0x6c(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movzwq	0x8(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x98(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
