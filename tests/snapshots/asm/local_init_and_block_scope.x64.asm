
local_init_and_block_scope.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400253 <.text+0x33>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	$0x41, %r9d
               	leaq	0xfe4f(%rip), %r8       # 0x4100d0
               	movl	$0x1, %edi
               	movl	%edi, -0x20(%rbp)
               	movl	$0x3, %esi
               	movl	$0x2, %edi
               	movslq	%r11d, %rdx
               	cmpq	$0x0, %rdx
               	je	0x4002ca <.text+0xaa>
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %r11
               	andq	$0xff, %r11
               	movq	%r11, %rdx
               	xorq	$0x41, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rdx, %r11
               	cmpq	$0x0, %r11
               	je	0x40031c <.text+0xfc>
               	movl	$0x2, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%r8), %rdx
               	movq	%rdx, %r11
               	xorq	$0x68, %r11
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	je	0x400366 <.text+0x146>
               	movl	$0x3, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r8
               	movq	%r8, %r11
               	xorq	$0x69, %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4003bc <.text+0x19c>
               	movl	$0x4, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %r11
               	movslq	%edi, %r8
               	movq	%r11, %rdx
               	addq	%r8, %rdx
               	movslq	%edx, %rdx
               	movslq	%esi, %r8
               	movq	%rdx, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x6, %r11
               	je	0x40040d <.text+0x1ed>
               	movl	$0x5, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x20(%rbp), %rbx
               	movslq	%edi, %r12
               	movslq	%esi, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r15
               	movslq	%r15d, %r14
               	cmpq	$0x6, %r14
               	je	0x400460 <.text+0x240>
               	movl	$0x6, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%r15d, %r12
               	movq	%r12, %r14
               	shlq	$0x1, %r14
               	movslq	%r14d, %r14
               	movslq	%r14d, %r12
               	cmpq	$0xc, %r12
               	je	0x4004a5 <.text+0x285>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %ebx
               	movl	$0x14, %r14d
               	movl	$0x1e, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdx
               	movslq	%edx, %r12
               	cmpq	$0x3c, %r12
               	je	0x4004ff <.text+0x2df>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %edx
               	movslq	%edx, %r12
               	cmpq	$0x63, %r12
               	je	0x40053c <.text+0x31c>
               	movl	$0x9, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %edx
               	movslq	%edx, %r12
               	cmpq	$0x7, %r12
               	je	0x400579 <.text+0x359>
               	movl	$0xa, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%r15d, %rdx
               	cmpq	$0x6, %rdx
               	je	0x4005b0 <.text+0x390>
               	movl	$0xb, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movslq	(%r12), %rdx
               	cmpq	$0x1, %rdx
               	je	0x4005ec <.text+0x3cc>
               	movl	$0xc, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %r12
               	xorq	%rdx, %rdx
               	movl	%edx, (%r12)
               	leaq	-0x60(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x4, %r12
               	movl	%edx, (%r12)
               	leaq	-0x60(%rbp), %r15
               	leaq	-0x68(%rbp), %r12
               	pushq	%rax
               	movq	(%r15), %rax
               	movq	%rax, (%r12)
               	popq	%rax
               	movq	%r12, %rdx
               	leaq	-0x68(%rbp), %rdx
               	movslq	(%rdx), %r12
               	cmpq	$0x0, %r12
               	je	0x400659 <.text+0x439>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rdx
               	movq	%rdx, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rdx
               	cmpq	$0x0, %rdx
               	je	0x40069f <.text+0x47f>
               	movl	$0xe, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
