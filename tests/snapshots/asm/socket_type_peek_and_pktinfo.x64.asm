
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

<pktinfo_round_trip>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x10, -0x80(%rbp)
               	movb	$0x70, -0x78(%rbp)
               	movl	$0x1, -0x70(%rbp)
               	movl	$0x2, %edi
               	xorl	%edx, %edx
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	xorl	%esi, %esi
               	leaq	-0x68(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x78(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x1, -0x50(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, -0x28(%rbp)
               	movq	$0x1, -0x20(%rbp)
               	leaq	<rip>, %rax      # <addr>
               	xorl	%edx, %edx
               	movq	%rax, -0x18(%rbp)
               	movq	$0x28, -0x10(%rbp)
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
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
               	leaq	-0x48(%rbp), %rdi
               	leaq	0x10(%rbx), %rsi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ebx, %ebx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorl	%edx, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	$0x4, -0x10(%rbp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	-0x20(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x1c(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %edi
               	xorl	%edx, %edx
               	leaq	-0x20(%rbp), %rcx
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	-0x1c(%rbp), %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movl	-0x20(%rbp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	-0x1c(%rbp), %edi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movsbq	-0x8(%rbp), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	-0x1c(%rbp), %edi
               	movl	$0x2, %edx
               	movl	$0x100, %ecx            # imm = 0x100
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x1c(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	leave
               	retq
