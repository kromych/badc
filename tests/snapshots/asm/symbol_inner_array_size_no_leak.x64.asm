
symbol_inner_array_size_no_leak.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002c5 <.text+0xa5>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	0x4002a7 <.text+0x87>
               	jmp	0x40027c <.text+0x5c>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %r8
               	movq	%r8, %rsi
               	shlq	$0x1, %rsi
               	movq	%r11, %rdi
               	addq	%rsi, %rdi
               	movl	$0x3, %r10d
               	imulq	%r10, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	movw	%r8w, (%rdi)
               	jmp	0x400266 <.text+0x46>
               	subq	$0x1, %r9
               	movslq	%r9d, %r9
               	shlq	$0x1, %r9
               	addq	%r9, %r11
               	movswq	(%r11), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rbx
               	movl	$0x8, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	je	0x40031c <.text+0xfc>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movswq	(%rax), %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x30(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40036b <.text+0x14b>
               	leaq	-0x10(%rbp), %rax
               	addq	$0xe, %rax
               	movswq	(%rax), %r12
               	cmpq	$0x15, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x30(%rbp)
               	jmp	0x40036b <.text+0x14b>
               	movq	-0x30(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400399 <.text+0x179>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r12
               	addq	$0xe, %r12
               	movl	$0x63, %eax
               	movw	%ax, (%r12)
               	leaq	-0x28(%rbp), %rbx
               	addq	$0xe, %rbx
               	movswq	(%rbx), %rax
               	cmpq	$0x63, %rax
               	je	0x4003e7 <.text+0x1c7>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
