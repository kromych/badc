
socket_type_peek_and_pktinfo.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0xc8, %rsp
               	xorl	%edx, %edx
               	movl	%edx, 0x28(%rsp)
               	movl	$0x4, 0x30(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	0x20(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	leaq	0x28(%rsp), %rcx
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	callq	<addr>
               	movl	0x24(%rsp), %edi
               	callq	<addr>
               	movl	$0x1, %edi
               	movl	$0x1, %esi
               	xorl	%edx, %edx
               	leaq	0x20(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	0x24(%rsp), %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	leaq	0x28(%rsp), %rcx
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	0x24(%rsp), %edi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	0x38(%rsp), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	0x24(%rsp), %edi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x2, %edx
               	movl	$0x100, %ecx            # imm = 0x100
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	0x20(%rsp), %edi
               	callq	<addr>
               	movl	0x24(%rsp), %edi
               	callq	<addr>
               	movl	$0x10, 0x40(%rsp)
               	movb	$0x70, 0x48(%rsp)
               	movl	$0x1, 0x50(%rsp)
               	movl	$0x2, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	$0x0, 0x60(%rsp)
               	movq	$0x2, 0x58(%rsp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	callq	<addr>
               	movl	%eax, 0x5c(%rsp)
               	movq	0x18(%rsp), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	movq	0x18(%rsp), %rdi
               	leaq	0x58(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0xc8, %rsp
               	retq
               	addq	$0xc8, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	leaq	0x58(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	leaq	0x50(%rsp), %rcx
               	movl	$0x4, %r8d
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movq	0x18(%rsp), %rdi
               	leaq	0x48(%rsp), %rsi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	leaq	0x58(%rsp), %r8
               	movl	$0x10, %r9d
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	leaq	0x68(%rsp), %rcx
               	leaq	0x48(%rsp), %rax
               	movq	%rax, 0x68(%rsp)
               	movq	$0x1, 0x70(%rsp)
               	xorl	%edx, %edx
               	movq	%rdx, 0x88(%rsp)
               	movq	%rdx, 0x90(%rsp)
               	movq	%rdx, 0xb8(%rsp)
               	movq	%rcx, 0x98(%rsp)
               	movq	$0x1, 0xa0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, 0xa8(%rsp)
               	movq	$0x28, 0xb0(%rsp)
               	movq	0x18(%rsp), %rdi
               	leaq	0x88(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movq	0xb0(%rsp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	0xa8(%rsp), %rcx
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdx, 0x8(%rsp)
               	movq	%rcx, %rsi
               	leaq	0x88(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x8(%rsp), %rdx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	leaq	0x78(%rsp), %rax
               	leaq	0x10(%rcx), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	0x18(%rcx), %r10d
               	movq	%r10, 0x10(%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	callq	<addr>
               	movl	%eax, %eax
               	movq	0x8(%rsp), %rcx
               	movq	%rax, %r10
               	movq	0x10(%rsp), %rax
               	cmpq	%r10, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	je	<addr>
               	movl	0x78(%rsp), %eax
               	testl	%eax, %eax
               	setg	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	movq	%rdx, 0x8(%rsp)
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0xa, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	movl	$0x29, %esi
               	movl	$0x31, %edx
               	leaq	0x50(%rsp), %rcx
               	movl	$0x4, %r8d
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
