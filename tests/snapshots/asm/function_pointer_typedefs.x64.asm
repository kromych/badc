
function_pointer_typedefs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002cc <.text+0xac>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	subq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	cmpq	%r9, %r11
               	jge	0x40026b <.text+0x4b>
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	%r9, %r11
               	jle	0x40027a <.text+0x5a>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movslq	%edx, %r14
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0xa0(%rip), %rbx       # 0x400251 <.text+0x31>
               	movl	$0x3, %r12d
               	movl	$0x5, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	cmpq	$-0x1, %rax
               	je	0x40033e <.text+0x11e>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r15d
               	movl	$0x2, %r12d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	cmpq	$0x1, %rax
               	je	0x40038b <.text+0x16b>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %r14d
               	movq	%rbx, %r11
               	movq	%r14, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	je	0x4003d2 <.text+0x1b2>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x1a6(%rip), %r14      # 0x400237 <.text+0x17>
               	movq	%r14, (%rax)
               	leaq	-0x20(%rbp), %rbx
               	addq	$0x8, %rbx
               	leaq	-0x1ae(%rip), %r14      # 0x400244 <.text+0x24>
               	movq	%r14, (%rbx)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-0x1b6(%rip), %r14      # 0x400251 <.text+0x31>
               	movq	%r14, (%rax)
               	leaq	-0x20(%rbp), %rbx
               	movq	(%rbx), %r12
               	movl	$0x2, %r14d
               	movl	$0x3, %ebx
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x5, %rax
               	je	0x40045c <.text+0x23c>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r15
               	movl	$0xa, %ebx
               	movl	$0x4, %r12d
               	movq	%r15, %r11
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	cmpq	$0x6, %rax
               	je	0x4004b6 <.text+0x296>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r14
               	movl	$0x1, %r12d
               	movl	$0x2, %r15d
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	cmpq	$-0x1, %rax
               	je	0x400511 <.text+0x2f1>
               	movl	$0x6, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x2e1(%rip), %rbx      # 0x400237 <.text+0x17>
               	movl	$0x8, %r14d
               	movl	$0x9, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	0x400281 <.text+0x61>
               	cmpq	$0x11, %rax
               	je	0x400567 <.text+0x347>
               	movl	$0x7, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
