
pointer_to_array_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400476 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfda9(%rip)           # 0x410100
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd96(%rip), %r9       # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x4003c5 <.text+0x85>
               	leaq	0xfd75(%rip), %r9       # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfd55(%rip), %rdi      # 0x410128
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfd46(%rip), %rdi      # 0x41012e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfd38(%rip), %rdi      # 0x410135
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400897 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400447 <.text+0x107>
               	leaq	0xfcde(%rip), %r14      # 0x410110
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400447 <.text+0x107>
               	leaq	0xfcc2(%rip), %r12      # 0x410110
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x40, %r9d
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x40089d <malloc>
               	movq	%rax, (%rbx)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %rax
               	cmpq	$0x0, %rax
               	jne	0x4004eb <.text+0x1ab>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x4004f6 <.text+0x1b6>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	0x40052f <.text+0x1ef>
               	jmp	0x400524 <.text+0x1e4>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	jmp	0x4004f6 <.text+0x1b6>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	0x40053a <.text+0x1fa>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x4005ae <.text+0x26e>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	0x4005a9 <.text+0x269>
               	jmp	0x400565 <.text+0x225>
               	leaq	-0x18(%rbp), %rbx
               	movslq	(%rbx), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x40053a <.text+0x1fa>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r12
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %rbx
               	shlq	$0x4, %rbx
               	addq	%rbx, %r12
               	movslq	-0x18(%rbp), %rbx
               	movq	%rbx, %rdi
               	shlq	$0x1, %rdi
               	addq	%rdi, %r12
               	movl	$0x64, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	movw	%ax, (%r12)
               	jmp	0x400550 <.text+0x210>
               	jmp	0x40050c <.text+0x1cc>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	0x4005e4 <.text+0x2a4>
               	jmp	0x4005d9 <.text+0x299>
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x4005ae <.text+0x26e>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	0x400616 <.text+0x2d6>
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rax
               	movabsq	$-0x1, %rdi
               	movw	%di, (%rax)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %rdi
               	movswq	(%rdi), %r12
               	cmpq	$-0x1, %r12
               	je	0x400702 <.text+0x3c2>
               	jmp	0x4006db <.text+0x39b>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	0x400690 <.text+0x350>
               	jmp	0x400644 <.text+0x304>
               	leaq	-0x18(%rbp), %r12
               	movslq	(%r12), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	jmp	0x400616 <.text+0x2d6>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rbx
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r12
               	shlq	$0x4, %r12
               	addq	%r12, %rbx
               	movslq	-0x18(%rbp), %r12
               	movq	%r12, %rdi
               	shlq	$0x1, %rdi
               	addq	%rdi, %rbx
               	movswq	(%rbx), %rdi
               	movl	$0x64, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movswq	%ax, %rax
               	cmpq	%rax, %rdi
               	je	0x4006d6 <.text+0x396>
               	jmp	0x400695 <.text+0x355>
               	jmp	0x4005c4 <.text+0x284>
               	movslq	-0x10(%rbp), %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movslq	-0x18(%rbp), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	0x40062c <.text+0x2ec>
               	movl	$0x63, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x4008a3 <free>
               	movslq	%eax, %rax
               	leaq	0xfa42(%rip), %r15      # 0x410160
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x4008a9 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
