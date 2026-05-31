
function_pointer_typedefs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d2 <.text+0xb2>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	cmpq	%r9, %r11
               	jge	0x400271 <.text+0x51>
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	%r9, %r11
               	jle	0x400280 <.text+0x60>
               	movl	$0x1, %eax
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
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
               	leaq	-0xa0(%rip), %rbx       # 0x400257 <.text+0x37>
               	movl	$0x3, %r12d
               	movl	$0x5, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	cmpq	$-0x1, %rax
               	je	0x400343 <.text+0x123>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r15d
               	movl	$0x2, %r14d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	cmpq	$0x1, %rax
               	je	0x40038f <.text+0x16f>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %r12d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	je	0x4003d5 <.text+0x1b5>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	leaq	-0x1a9(%rip), %rax      # 0x400237 <.text+0x17>
               	movq	%rax, (%r12)
               	leaq	-0x20(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	leaq	-0x1b2(%rip), %rbx      # 0x400247 <.text+0x27>
               	movq	%rbx, (%rax)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rbx
               	addq	$0x10, %rbx
               	leaq	-0x1ba(%rip), %r12      # 0x400257 <.text+0x37>
               	movq	%r12, (%rbx)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r14
               	movl	$0x2, %r12d
               	movl	$0x3, %r15d
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	cmpq	$0x5, %rax
               	je	0x400467 <.text+0x247>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rbx
               	movl	$0xa, %r15d
               	movl	$0x4, %r14d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	cmpq	$0x6, %rax
               	je	0x4004c4 <.text+0x2a4>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r12
               	movl	$0x1, %r14d
               	movl	$0x2, %ebx
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$-0x1, %rax
               	je	0x400520 <.text+0x300>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x2f0(%rip), %r15      # 0x400237 <.text+0x17>
               	movl	$0x8, %ebx
               	movl	$0x9, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	callq	0x400287 <.text+0x67>
               	cmpq	$0x11, %rax
               	je	0x400574 <.text+0x354>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
