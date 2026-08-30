
inline_asm_x64_flag_outputs.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %r8
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rdi, -0x58(%rbp)
               	movq	%r8, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %r10
               	movb	%bl, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	movq	%rax, (%rdx)
               	movzbq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movq	%rax, (%rsi)
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ecx
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %r8
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rdi, -0x58(%rbp)
               	movq	%r8, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %r10
               	movb	%bl, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	movq	%rax, (%rdx)
               	movzbq	-0x8(%rbp), %rax
               	addq	$0xc, %rax
               	movq	%rax, (%rsi)
               	movq	-0x20(%rbp), %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0xd, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x58(%rbp), %rbx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x58(%rbp), %rbx
               	testq	%rbx, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movzbq	-0x10(%rbp), %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rcx
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	-0x58(%rbp), %rbx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %edx
               	testl	%edx, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x58(%rbp), %rbx
               	testq	%rbx, %rbx
               	sets	%al
               	movzbq	%al, %rax
               	movq	-0x60(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movzbq	-0x10(%rbp), %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x1, %edx
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %r10
               	movb	%bl, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %edx
               	testl	%edx, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	seto	%bl
               	movzbq	%bl, %rbx
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %r10
               	movb	%bl, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movzbq	-0x10(%rbp), %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movl	$0x7, %edx
               	movl	%ecx, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x58(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movabsq	$-0x1, %rdx
               	movl	%edx, -0x10(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x58(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movslq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
