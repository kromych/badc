
socket_type_peek_and_pktinfo.x64:	file format elf64-x86-64

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
               	subq	$0xa8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edx, %edx
               	movl	%edx, -0x98(%rbp)
               	movl	$0x4, -0x90(%rbp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	-0xa0(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0xa0(%rbp), %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	leaq	-0x98(%rbp), %rcx
               	leaq	-0x90(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x98(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0xa0(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x9c(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %edi
               	xorl	%edx, %edx
               	leaq	-0xa0(%rbp), %rcx
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0x9c(%rbp), %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	leaq	-0x98(%rbp), %rcx
               	leaq	-0x90(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x98(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movl	-0xa0(%rbp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0x9c(%rbp), %edi
               	leaq	-0x88(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movsbq	-0x88(%rbp), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0x9c(%rbp), %edi
               	movl	$0x2, %edx
               	movl	$0x100, %ecx            # imm = 0x100
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0xa0(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x9c(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x10, -0x80(%rbp)
               	movb	$0x70, -0x78(%rbp)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x2, %edi
               	xorl	%edx, %edx
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x0, -0x68(%rbp)
               	movl	$0x0, -0x64(%rbp)
               	movl	$0x0, -0x60(%rbp)
               	movl	$0x0, -0x5c(%rbp)
               	movw	$0x2, -0x68(%rbp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, -0x64(%rbp)
               	testl	%r13d, %r13d
               	jl	<addr>
               	leaq	-0x68(%rbp), %rsi
               	movl	$0x10, %edx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x68(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	leaq	-0x70(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rsi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x68(%rbp), %r8
               	movl	$0x10, %r9d
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x1, -0x50(%rbp)
               	xorl	%edx, %edx
               	movq	%rdx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x58(%rbp), %rcx
               	movq	%rcx, -0x28(%rbp)
               	leaq	-0x38(%rbp), %rsi
               	movq	$0x1, -0x20(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, -0x18(%rbp)
               	movq	$0x28, -0x10(%rbp)
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	-0x18(%rbp), %rbx
               	xorl	%r12d, %r12d
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpl	$0x0, 0x8(%rbx)
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	leaq	0x10(%rbx), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	-0x40(%rbp), %r12d
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %r12
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%r12d, %r12d
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x48(%rbp), %eax
               	testl	%eax, %eax
               	setg	%r12b
               	movzbq	%r12b, %r12
               	leaq	-0x38(%rbp), %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0xa, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jl	<addr>
               	movl	$0x29, %esi
               	movl	$0x31, %edx
               	leaq	-0x70(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
