
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40048d <.text+0x21d>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	(%r11), %r8
               	movslq	(%r9), %rdi
               	movl	%edi, (%r11)
               	movslq	%r8d, %r8
               	movl	%r8d, (%r9)
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
               	jge	0x400343 <.text+0xd3>
               	jmp	0x40031f <.text+0xaf>
               	leaq	-0x18(%rbp), %rdx
               	movslq	(%rdx), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdx)
               	jmp	0x4002f7 <.text+0x87>
               	movslq	-0x18(%rbp), %r9
               	shlq	$0x2, %r9
               	movq	0x28(%rsp), %rsi
               	addq	%r9, %rsi
               	movslq	(%rsi), %r9
               	movslq	%r14d, %rsi
               	cmpq	%rsi, %r9
               	jg	0x4003e5 <.text+0x175>
               	jmp	0x4003a4 <.text+0x134>
               	movslq	-0x10(%rbp), %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	shlq	$0x2, %rbx
               	movq	0x28(%rsp), %r15
               	addq	%rbx, %r15
               	shlq	$0x2, %r12
               	movq	0x28(%rsp), %r14
               	addq	%r12, %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	callq	0x400287 <.text+0x17>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
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
               	addq	$0x1, %r9
               	movl	%r9d, (%rsi)
               	movslq	-0x10(%rbp), %rdx
               	shlq	$0x2, %rdx
               	movq	0x28(%rsp), %r15
               	addq	%rdx, %r15
               	movslq	-0x18(%rbp), %rdx
               	shlq	$0x2, %rdx
               	movq	0x28(%rsp), %rbx
               	addq	%rdx, %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	0x400287 <.text+0x17>
               	jmp	0x4003e5 <.text+0x175>
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
               	jge	0x400468 <.text+0x1f8>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x4002a0 <.text+0x30>
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	subq	$0x1, %rdi
               	movslq	%edi, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	callq	0x4003ea <.text+0x17a>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x4003ea <.text+0x17a>
               	jmp	0x400468 <.text+0x1f8>
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
               	callq	0x4007a7 <malloc>
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
               	callq	0x4003ea <.text+0x17a>
               	movslq	(%r12), %rax
               	cmpq	$0x5, %rax
               	je	0x400555 <.text+0x2e5>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x7, %rbx
               	je	0x400591 <.text+0x321>
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
               	je	0x4005cd <.text+0x35d>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0xc, %rbx
               	je	0x400609 <.text+0x399>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addq	$0x10, %r12
               	movslq	(%r12), %rbx
               	cmpq	$0xf, %rbx
               	je	0x400644 <.text+0x3d4>
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
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
