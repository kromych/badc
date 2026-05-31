
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4004ad <.text+0x23d>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	(%r11), %r8
               	movslq	(%r9), %rdi
               	movl	%edi, (%r11)
               	movslq	%r8d, %rsi
               	movl	%esi, (%r9)
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x28(%rsp)
               	movslq	%esi, %r9
               	movslq	%edx, %r12
               	movq	%r12, %rdi
               	shlq	$0x2, %rdi
               	movq	0x28(%rsp), %rsi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %r14
               	movq	%r9, %rsi
               	subq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x4002f7 <.text+0x87>
               	movslq	-0x18(%rbp), %r9
               	cmpq	%r12, %r9
               	jge	0x400349 <.text+0xd9>
               	jmp	0x400322 <.text+0xb2>
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r9)
               	jmp	0x4002f7 <.text+0x87>
               	movslq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	movq	0x28(%rsp), %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	movslq	%r14d, %rsi
               	cmpq	%rsi, %rdx
               	jg	0x4003ff <.text+0x18f>
               	jmp	0x4003b6 <.text+0x146>
               	movslq	-0x10(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	shlq	$0x2, %rbx
               	movq	0x28(%rsp), %r15
               	addq	%rbx, %r15
               	movq	%r12, %rbx
               	shlq	$0x2, %rbx
               	movq	0x28(%rsp), %r14
               	addq	%rbx, %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	callq	0x400287 <.text+0x17>
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %r9
               	movq	%r9, %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rsi)
               	movslq	-0x10(%rbp), %r9
               	movq	%r9, %rdx
               	shlq	$0x2, %rdx
               	movq	0x28(%rsp), %r15
               	addq	%rdx, %r15
               	movslq	-0x18(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	movq	0x28(%rsp), %rbx
               	addq	%rsi, %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	0x400287 <.text+0x17>
               	jmp	0x4003ff <.text+0x18f>
               	jmp	0x400309 <.text+0x99>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movslq	%edx, %r14
               	cmpq	%r14, %r12
               	jge	0x400488 <.text+0x218>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x4002a0 <.text+0x30>
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	movq	%rdi, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	callq	0x400404 <.text+0x194>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r12
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x400404 <.text+0x194>
               	jmp	0x400488 <.text+0x218>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x14, %r11d
               	movslq	%r11d, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4007c7 <malloc>
               	movq	%rax, %r12
               	xorq	%r14, %r14
               	movl	$0xc, %r8d
               	movl	%r8d, (%r12)
               	movl	$0x4, %ebx
               	movq	%r12, %r8
               	addq	$0x4, %r8
               	movl	$0x7, %esi
               	movl	%esi, (%r8)
               	movq	%r12, %rdx
               	addq	$0x8, %rdx
               	movl	$0xf, %esi
               	movl	%esi, (%rdx)
               	movq	%r12, %r8
               	addq	$0xc, %r8
               	movl	$0x5, %esi
               	movl	%esi, (%r8)
               	movq	%r12, %rdx
               	addq	$0x10, %rdx
               	movl	$0xa, %esi
               	movl	%esi, (%rdx)
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	0x400404 <.text+0x194>
               	movslq	(%r12), %rax
               	cmpq	$0x5, %rax
               	je	0x400575 <.text+0x305>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x7, %rax
               	je	0x4005b1 <.text+0x341>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0xa, %rax
               	je	0x4005ed <.text+0x37d>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rbx
               	addq	$0xc, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0xc, %rax
               	je	0x400629 <.text+0x3b9>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rbx
               	addq	$0x10, %rbx
               	movslq	(%rbx), %r12
               	cmpq	$0xf, %r12
               	je	0x400666 <.text+0x3f6>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
