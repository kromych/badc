
pthread_rwlock_spin_barrier_and_attributes.x64:	file format elf64-x86-64

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

<reader>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	<rip>, %ebx # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x7, %ebx
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<reentrant>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x198, %rsp            # imm = 0x198
               	pushq	%rbx
               	movl	$0x5, -0x188(%rbp)
               	movl	$0x5, -0x180(%rbp)
               	movq	$0x0, -0x178(%rbp)
               	leaq	-0x188(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	leaq	-0x180(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movl	-0x188(%rbp), %eax
               	movl	-0x180(%rbp), %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	movq	$0x0, -0x150(%rbp)
               	movq	$0x0, -0x148(%rbp)
               	movq	$0x0, -0x140(%rbp)
               	movq	$0x0, -0x138(%rbp)
               	movq	$0x0, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
               	movq	$0x0, -0x120(%rbp)
               	movl	$0x46, -0x13c(%rbp)
               	movl	$0x1, -0x144(%rbp)
               	movl	$0x4, -0x138(%rbp)
               	leaq	-0x170(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x170(%rbp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	-0x118(%rbp), %rsi
               	leaq	-0x178(%rbp), %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x178(%rbp), %rax
               	leaq	-0x118(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<linux_only>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x158, %rsp            # imm = 0x158
               	pushq	%rbx
               	leaq	-0x130(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffff, -0x138(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x150(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x150(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	leaq	-0x150(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x120(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x120(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x120(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x148(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x148(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x138(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x138(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x148(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x140(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x140(%rbp), %edi
               	leaq	-0x130(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x20, %rax
               	jl	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %rbx
               	jg	<addr>
               	movl	$0x25, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x100(%rbp), %rsi
               	movq	%rdi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, -0x8(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	-0x8(%rbp), %rdx
               	movq	%rbx, %rdi
               	movq	(%rdx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x130(%rbp), %rdx
               	movq	$0x5, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movl	-0x68(%rbp), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0xffffffff, -0x48(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x7, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$0x0, -0x58(%rbp)
               	movl	$0xffffffff, -0x50(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x48(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x100000, %esi         # imm = 0x100000
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0x50(%rbp)
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0x50(%rbp)
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0x50(%rbp)
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %edi
               	leaq	-0x48(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	movl	-0x48(%rbp), %edi
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	-0x58(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x58(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x50(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	-0x58(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rdi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x58(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x50(%rbp)
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
